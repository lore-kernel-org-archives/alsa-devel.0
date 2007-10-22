From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: WM9712 monoout
Date: Mon, 22 Oct 2007 16:12:14 +0200
Message-ID: <471CAFBE.9060509@compulab.co.il>
References: <471B012E.6050802@compulab.co.il>
	<1193050024.7052.132.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sa14.bezeqint.net (sa14.bezeqint.net [192.115.104.29])
	by alsa0.perex.cz (Postfix) with ESMTP id B26F524543
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Oct 2007 16:21:32 +0200 (CEST)
In-Reply-To: <1193050024.7052.132.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Liam Girdwood wrote:
> On Sun, 2007-10-21 at 09:35 +0200, Mike Rapoport wrote:
>> Hello,
>>
>> I'm trying to enable phone on a board with WM9715 codec.
>> I have not found a control responsible for mute/unmute the MONOUT.
>> My question is whether I should add this control as platform specific control,
>> or it would be correct to patch sound/soc/codecs/wm9712.c?
> 
> It should probably go in the codec driver. It looks like an omission.
> 
>> Also, "Mono Playback Volume" control is not inverted, which seems to be a bug.
>>
> 
> Could you send a patch ?

Sure. A also found that treble and bass need to be inverted.

> Many Thanks
> 
> Liam
> 

Signed-off-by: Mike Rapoport <mike@compulab.co.il>

 sound/soc/codecs/wm9712.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 986b5d5..427cb61 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -102,7 +102,8 @@ SOC_SINGLE("Speaker Playback ZC Switch", AC97_MASTER, 7, 1, 0),
 SOC_SINGLE("Speaker Playback Invert Switch", AC97_MASTER, 6, 1, 0),
 SOC_SINGLE("Headphone Playback ZC Switch", AC97_HEADPHONE, 7, 1, 0),
 SOC_SINGLE("Mono Playback ZC Switch", AC97_MASTER_MONO, 7, 1, 0),
-SOC_SINGLE("Mono Playback Volume", AC97_MASTER_MONO, 0, 31, 0),
+SOC_SINGLE("Mono Playback Volume", AC97_MASTER_MONO, 0, 31, 1),
+SOC_SINGLE("Mono Playback Switch", AC97_MASTER_MONO, 15, 1, 1),

 SOC_SINGLE("ALC Target Volume", AC97_CODEC_CLASS_REV, 12, 15, 0),
 SOC_SINGLE("ALC Hold Time", AC97_CODEC_CLASS_REV, 8, 15, 0),
@@ -145,8 +146,8 @@ SOC_ENUM("Bass Control", wm9712_enum[5]),
 SOC_SINGLE("Bass Cut-off Switch", AC97_MASTER_TONE, 12, 1, 1),
 SOC_SINGLE("Tone Cut-off Switch", AC97_MASTER_TONE, 4, 1, 1),
 SOC_SINGLE("Playback Attenuate (-6dB) Switch", AC97_MASTER_TONE, 6, 1, 0),
-SOC_SINGLE("Bass Volume", AC97_MASTER_TONE, 8, 15, 0),
-SOC_SINGLE("Treble Volume", AC97_MASTER_TONE, 0, 15, 0),
+SOC_SINGLE("Bass Volume", AC97_MASTER_TONE, 8, 15, 1),
+SOC_SINGLE("Treble Volume", AC97_MASTER_TONE, 0, 15, 1),

 SOC_SINGLE("Capture ADC Switch", AC97_REC_GAIN, 15, 1, 1),
 SOC_ENUM("Capture Volume Steps", wm9712_enum[6]),
