From: Craig McQueen <craig.mcqueen@beamcommunications.com>
Subject: Pop and offsets at start of audio playback/record for
 SGTL5000 on i.MX28
Date: Fri, 14 Nov 2014 12:43:17 +1100
Message-ID: <54655E35.9000807@beamcommunications.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APAC01-SG1-obe.outbound.protection.outlook.com
 (mail-sg1on0081.outbound.protection.outlook.com [134.170.132.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 687DD2604E8
 for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2014 02:43:28 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I'm testing the 3.14.19 kernel for i.MX28 EVK, which has an SGTL5000 
CODEC. I've also tested on the 3.18-rc4 kernel and confirmed this issue 
still occurs.


Playback

When doing audio playback, I notice that the audio "fades in" over the 
first (approximately) 500 ms of playback. This is very noticeable and 
not ideal in certain applications (e.g. audio notifications that are of 
short duration).

However, if audio playback starts while audio recording is already 
in-progress, then there is no fade-in; instead there is a loud pop. I 
assume the fade-in is there to mask the pop. The pop is very unpleasant 
through headphones. (However, if I do audio playback a _second_ time 
while audio recording is still in-progress, then there is no loud pop 
the second time.)

I didn't think either the pop or the fade-in occurred on the 2.6.35 
kernel. How feasible is it to improve the driver to avoid or reduce the 
pop, and remove the necessity for a fade-in?


Record

When recording, I notice there is a low-frequency ramping offset at the 
start of a recording (after the 400-500 ms of previous audio) of approx 
600-700 ms duration. This also reduces the audio quality at the start of 
the recording. It could reduce the quality of captured audio depending 
on the application usage. I am getting distortion (clipping I assume) of 
my audio input during this time. It could cause a pop on playback (local 
playback or e.g. VoIP transmission to a remote device). It could reduce 
the audio quality through an audio CODEC.

How feasible is it to improve the driver to avoid a ramping offset at 
the start of recording?

-- 
Craig McQueen
