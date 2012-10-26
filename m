From: Rick Kirk <arkays.email@gmail.com>
Subject: Edirol M-16DX workaround found.
Date: Fri, 26 Oct 2012 12:27:26 +1100
Message-ID: <20121026012726.GA1683@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f51.google.com (mail-da0-f51.google.com
 [209.85.210.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 24BFA265085
 for <alsa-devel@alsa-project.org>; Fri, 26 Oct 2012 03:27:33 +0200 (CEST)
Received: by mail-da0-f51.google.com with SMTP id t11so970819daj.38
 for <alsa-devel@alsa-project.org>; Thu, 25 Oct 2012 18:27:32 -0700 (PDT)
Content-Disposition: inline
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

Hi Everyone.

I recently purchased an Edirol M-16DX digital Mixer and am using it with Arch Linux. Alsa version is 1.0.26.

After searching the internet and in particular the alsa-devel archives I came across some discussion about this particular device dating back to 2008/09.

The device has a built in USB sound card.  A patch was added a long time to allow the device to function with the Alsa usb audio driver. 
Everything worked as expected except for a playback issue that results in a ring modulation like distortion of the audio at fixed intervals (dependant on the frequency in use).  
At the time those investigating the issue didn't recieve any information back from testers and were unable to resolve the issue and the patch was released with the understanding that device was not fully functional.

The proposed fix at the time was to make the device capture audio during playback, even if no recording was being made, thereby using the interal capture clock to sync playback. This was never implemented for various reasons.  

I have found a workaround for this issue.  The device has a digital SPDIF input.  With the USB outputs on the device not working it made sense to use my onboard audio card via SPDIF to create a digital path from the PC to the mixer to allow use of PC sound with the mixer.

I found upon connecting the SPDIF that the Edirol immediately synced to the external PC clock signal via the coax SPDIF connection.  As a result the audio distortion was gone, making the device function as intended. (tested at 48khz though I expect it will work for 44.1khz and 96khz also).

The downside to this is that I have lost a stereo input (input 14 is SPDIF or stereo in, not both).  I now have 2 ways of using PC based audio with the machine (USB and SPDIF), or none if I stop using the SPDIF connection.

This discovery proves that the playback issue is purely a lack of clock sync.  I have tested this by setting the internal card to 44.1khz and the edirol to 48khz. The edirol loses external sync and shows on screen that the device switches back to "internal clock".  The distortion resurfaces until I force the PC onboard audio back to 48khz, providing a useful external clock source to the edirol via the SPDIF signal.

It would appear that the previously proposed fix of capturing while playing back may not be needed and my hope is that the fix might be far simpler to implement.  
I hope that this information is useful to those previoulsy involved.

I would like to as what would be required to enable a clock sync via the USB connection between the PC and mixer?  
I would be happy to help with beta testing for anyone interested in taking a look at this issue.  
I have also read that there are other devices that suffer from this same fault so there is potential that any fix may apply to more than this one device.

Alternately, if no-one has the time/interest to work directly on the problem then perhaps someone could suggest how the sync might be accomplished and where in the code to start looking? 
I can then attempt to patch the code myself, though it is likely well beyond my abilities.

Thanks for any assistance.

Regards,

Rick.

P.S.  I have also requested technical documentation from Roland for this device in the hope they will provide it as the device in now out of production.  I am yet to hear anything back.
