From: David Henningsson <david.henningsson@canonical.com>
Subject: HDMI Repoll after pm?
Date: Thu, 10 Dec 2015 10:47:59 +0100
Message-ID: <56694A4F.8070104@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 58B16265083
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2015 10:48:03 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

A recent change in sound.git seems to have introduced some repoll after 
pm. Is this an intentional change? I don't think it's wrong per se (it 
stops after 6 repolls), but it breaks my hda-emu tester when "list" does 
not return the expected input.

To reproduce, try running:

./hda-emu 
codecs/canonical/92hd91bxx-dell-inspiron-5423-ccert-201208-11456 -i 1
 > pm
.... lots of data ....
** TEST_PM DONE **
HDMI status: Codec=3 Pin=5 Presence_Detect=0 ELD_Valid=0
JACK report HDMI/DP, status 0
 > list
1: HDMI/DP Jack:0 (1)
2: IEC958 Playback Con Mask:0 (1)
3: IEC958 Playback Pro Mask:0 (1)
4: IEC958 Playback Default:0 (1)
5: IEC958 Playback Switch:0 (1)
6: ELD:0 (1)
7: Playback Channel Map:0 (1)
HDMI status: Codec=3 Pin=5 Presence_Detect=0 ELD_Valid=0
JACK report HDMI/DP, status 0
 >

...notice how the last two lines are somewhat unexpected output for a 
"list" command, but I can make my tool more robust in case you confirm 
this is an expected change.

// David
