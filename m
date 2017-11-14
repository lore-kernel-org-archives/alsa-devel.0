From: Henrik Eriksson <henrik.eriksson@axis.com>
Subject: Re: dsnoop, hwpointer and avail
Date: Tue, 14 Nov 2017 17:29:36 +0100
Message-ID: <20171114162936.GD5483@lnxhenriken2.se.axis.com>
References: <20171110122943.GB5483@lnxhenriken2.se.axis.com>
 <20171113101243.GC5483@lnxhenriken2.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 06F33266F4E
 for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2017 17:29:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id 4912E184DD
 for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2017 17:29:39 +0100 (CET)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id nz6Al9e94rXD for <alsa-devel@alsa-project.org>;
 Tue, 14 Nov 2017 17:29:36 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
 by bastet.se.axis.com (Postfix) with ESMTPS id AD5F618485
 for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2017 17:29:36 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8AE081A080
 for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2017 17:29:36 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 801F21A07B
 for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2017 17:29:36 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
 by boulder02.se.axis.com (Postfix) with ESMTP
 for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2017 17:29:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171113101243.GC5483@lnxhenriken2.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon,=A0Nov=A013,=A02017=A0at=A011:12:43=A0+0100, Henrik Eriksson wrote:
> On Fri,=A0Nov=A010,=A02017=A0at=A013:29:43=A0+0100, Henrik Eriksson wrote:
> > Is there any documentation/rationale for how pcm_dsnoop works in
> > snd_pcm_{dsnoop_}status?  I am particularly wondering about the ordering
> > of the snd_pcm_dsnoop_sync_ptr and the snd_pcm_status call on the slave
> > pcm.
> > =

> > I see occasional spikes (>1000 frames) of difference between the slave
> > pcm hwpointer after the snd_pcm_status call on it and the pointers in
> > the dsnoop pcm, and a correspondingly bad avail count.  I suspect the
> > mismatches are due to process scheduling (the slave pcm status is
> > delayed because the application process not running and the hardware
> > progresses during that delay).  Does this seem plausible?  If so, could
> > the code be simplified to reduce the the number of systemcalls needed?
> > The status of the slave pcm seems to provide much of the information
> > used to sync the pointers.  Or is there some other way to get a tighter
> > coupling between the dsnoop status htstamp and avail count?
> =

> Or, rather, in snd_pcm_dnsoop_status() would it not make more sense to
> use the dsnoop->update_tstamp as tstamp in the returned status, at least
> when the state is SNDRV_PCM_STATE_RUNNING?  The returned status->avail
> count originates from snd_pcm_dsnoop_sync_ptr() and it seems sensible to
> me that the tstamp would match that.
> =

> For background, this is on a machine with not mmap'ed status and control
> (in pcm_hw.c) and using slowptr in dsnoop.

Well, this change makes the linearity of repeated calls to
snd_pcm_status() and calculating status->tstamp - status->avail *
{sample rate} better when using dsnoop.  Does anyone have any input on
if something like this is reasonable?  Thanks.

Regards,
/henrik

From: Henrik Eriksson <henrik.eriksson@axis.com>
Subject: [PATCH] pcm: dsnoop: use tstamp from ptr sync in status

When snd_pcm_dsnoop_status() syncs the pointers it stores the tstamp
of its slave PCM.  Since the avail count returned in the status is
calculated on the mmap that is synced to the pointers use that tstamp
as status->tstamp.  This makes the returned avail count and tstamp match
closer than if tstamp is fetched from the subsequent status call on the
slave PCM, since this status call may be delayed due to the process
not being scheduled.

Signed-off-by: Henrik Eriksson <henrik.eriksson@axis.com>
---
 src/pcm/pcm_dsnoop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/pcm/pcm_dsnoop.c b/src/pcm/pcm_dsnoop.c
index 539b6711..c3600e74 100644
--- a/src/pcm/pcm_dsnoop.c
+++ b/src/pcm/pcm_dsnoop.c
@@ -30,6 +30,7 @@
 #include <stdlib.h>
 #include <stddef.h>
 #include <unistd.h>
+#include <stdbool.h>
 #include <signal.h>
 #include <string.h>
 #include <fcntl.h>
@@ -184,11 +185,13 @@ static int snd_pcm_dsnoop_status(snd_pcm_t *pcm, snd_=
pcm_status_t * status)
 {
 	snd_pcm_direct_t *dsnoop =3D pcm->private_data;
 	snd_pcm_state_t state;
+	bool synced =3D false;
 =

 	switch(dsnoop->state) {
 	case SNDRV_PCM_STATE_DRAINING:
 	case SNDRV_PCM_STATE_RUNNING:
 		snd_pcm_dsnoop_sync_ptr(pcm);
+		synced =3D true;
 		break;
 	default:
 		break;
@@ -196,6 +199,8 @@ static int snd_pcm_dsnoop_status(snd_pcm_t *pcm, snd_pc=
m_status_t * status)
 	memset(status, 0, sizeof(*status));
 	snd_pcm_status(dsnoop->spcm, status);
 	state =3D snd_pcm_state(dsnoop->spcm);
+	if (synced)
+		status->tstamp =3D dsnoop->update_tstamp;
 	status->state =3D state =3D=3D SND_PCM_STATE_RUNNING ? dsnoop->state : st=
ate;
 	status->trigger_tstamp =3D dsnoop->trigger_tstamp;
 	status->avail =3D snd_pcm_mmap_capture_avail(pcm);
-- =

2.11.0

 =
