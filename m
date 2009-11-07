From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/6] Fixups to MPC5200 ASoC drivers
Date: Sat, 7 Nov 2009 09:52:27 -0700
Message-ID: <fa686aa40911070852h5d09acafq4c55d838b7fb461e@mail.gmail.com>
References: <20091107081631.18908.82921.stgit@angua>
	<20091107125713.GF3228@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f190.google.com (mail-yw0-f190.google.com
	[209.85.211.190])
	by alsa0.perex.cz (Postfix) with ESMTP id EBBDD103823
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2009 17:52:49 +0100 (CET)
Received: by ywh28 with SMTP id 28so1704369ywh.16
	for <alsa-devel@alsa-project.org>; Sat, 07 Nov 2009 08:52:49 -0800 (PST)
In-Reply-To: <20091107125713.GF3228@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 7, 2009 at 5:57 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Nov 07, 2009 at 01:33:40AM -0700, Grant Likely wrote:
>> So, please test. =A0Let me know if these work or not. =A0I've don't know
>> if the last patch (Add fudge factor...) is needed or not.
>
> I've applied patches 1-5 since they seem fairly clear code cleanups and
> fixes. =A0If they've introduced any problems we can fix them incrementall=
y.
> I'll wait to see what the outcome of testing is for patch 6.

Cool, thanks!

> As I mentioned on IRC testing with PulseAudio would be good for this -
> it makes more demands on the quality of the DMA implementation than most
> applications.

I had trouble getting pulseaudio to work on my headless system.
Couldn't get clients to connect.  I'll hack on it again next week.

g.



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
