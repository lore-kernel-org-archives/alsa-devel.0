From: Nenghua Cao <nhcao@marvell.com>
Subject: [PATCH V2] ASOC:DAPM: update DPCM runtime when
	mixer/mux changes
Date: Fri, 13 Dec 2013 20:13:48 +0800
Message-ID: <1386936829-9627-1-git-send-email-nhcao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 24B33261589
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2013 13:08:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Yacine Belkadi <yacine.belkadi.1@gmail.com>, alsa-devel@alsa-project.org
Cc: Henry zhao <xzhao10@marvell.com>, Nenghua Cao <nhcao@marvell.com>, cxie4@marvell.com
List-Id: alsa-devel@alsa-project.org

From: Nenghua Cao <nhcao@marvell.com>

V2 -> V1:

   Removes the flag and update DPCM always when mixer/mux changes, according
to Takashi's and Mark's suggestion.

>> Usually backward compatibility is concerned when something new breaks
>> the existing ones.  In your case, always updating DPCM would work,
>> too, even without an extra flag; it's just suboptimal.

>Right, and if we have separate versions then at some point we'll end up
>having to define DPCM versions of everything which is going to get
>tedious and error prone.
 

V1 -> V0:

     refined patch, and add flag into soc_mixer_control and soc_enum 
instead of the alsa core, according to Takashi's suggestion.

> You don't need to extend the ALSA core API for such a purpose.  It's
> ASoC-specific, so rather extend struct soc_mixer_control instead, if
> such a new flag is really needed.


Nenghua Cao (1):
  ASOC:DAPM: update DPCM runtime when mixer/mux changes

 sound/soc/soc-dapm.c |   28 ++++++++++++++++++++++++----
 1 files changed, 24 insertions(+), 4 deletions(-)
