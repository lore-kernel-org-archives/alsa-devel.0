From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: [git pull] [PATCH 0/7] add support for many Roland
	and Yamaha devices
Date: Sat, 10 Aug 2013 13:35:13 +0100
Message-ID: <3149274.VsdRJhg8Vp@kamdesktop>
References: <51CC9D8B.7060601@ladisch.de> <4161390.DqJ0fEoIrV@kamdesktop>
 <52053269.2050706@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f41.google.com (mail-ee0-f41.google.com [74.125.83.41])
 by alsa0.perex.cz (Postfix) with ESMTP id E11202615F5
 for <alsa-devel@alsa-project.org>; Sat, 10 Aug 2013 14:35:15 +0200 (CEST)
Received: by mail-ee0-f41.google.com with SMTP id d17so2575287eek.14
 for <alsa-devel@alsa-project.org>; Sat, 10 Aug 2013 05:35:15 -0700 (PDT)
In-Reply-To: <52053269.2050706@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Friday 09 Aug 2013 20:18:17 Clemens Ladisch wrote:
> Keith A. Milner wrote:
> > On Friday 09 Aug 2013 15:17:08 Clemens Ladisch wrote:
> >> Keith A. Milner wrote:
> >>> I will mention, if it is of any importance, that I get the following
> >>> when
> >>> the driver is loaded:
> >>> 
> >>> [ 3340.089613] snd-usb-audio: probe of 1-6.2:1.2 failed with error -5
> >> 
> >> That looks like the MIDI interface.
> >> Do you have the MIDI ports (see "amidi -l")?
> > 
> > No MIDI ports show up. Nor are there any on the device or any that I'm
> > aware of that are "internal" to the device.
> 
> The descriptors says there are two ports, and the driver should be able
> to detect them.
> 
> >> Is there any error message in the system log?
> > 
> > Not really.
> 
> Please recompile the kernel with the option "More verbose debug"
> (CONFIG_SND_DEBUG_VERBOSE) enabled and try again.

Done:

Aug 10 13:27:44 KAMDesktop kernel: [  178.594760] usb 1-6.2: new high-speed 
USB device number 7 using ehci-pci
Aug 10 13:27:44 KAMDesktop kernel: [  178.688012] 7:0:1: add audio endpoint 
0x5
Aug 10 13:27:44 KAMDesktop kernel: [  178.688267] 7:1:1: add audio endpoint 
0x84
Aug 10 13:27:44 KAMDesktop kernel: [  178.688792] snd-usb-audio: probe of 
1-6.2:1.2 failed with error -5
Aug 10 13:27:44 KAMDesktop mtp-probe: checking bus 1, device 7: 
"/sys/devices/pci0000:00/0000:00:1a.7/usb1/1-6/1-6.2"
Aug 10 13:27:44 KAMDesktop mtp-probe: bus: 1, device: 7 was not an MTP device
Aug 10 13:27:44 KAMDesktop kernel: [  178.706558] setting usb interface 0:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.706561] Creating new playback data 
endpoint #5
Aug 10 13:27:44 KAMDesktop kernel: [  178.706564] Creating new capture data 
endpoint #84
Aug 10 13:27:44 KAMDesktop kernel: [  178.706753] Setting params for ep #5 
(type 0, 8 urbs), ret=0
Aug 10 13:27:44 KAMDesktop kernel: [  178.706754] match_endpoint_audioformats: 
(fmt @ffff88032febe500) score 2
Aug 10 13:27:44 KAMDesktop kernel: [  178.706759] Setting params for ep #84 
(type 0, 8 urbs), ret=0
Aug 10 13:27:44 KAMDesktop kernel: [  178.706760] Starting data EP 
@ffff88027a074000
Aug 10 13:27:44 KAMDesktop kernel: [  178.706926] Starting sync EP 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.719054] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.719056] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.719062] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.719075] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.719077] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.719091] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.719279] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.719609] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.719611] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.719696] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.719907] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.720563] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.720565] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.720569] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.720580] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.720582] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.720594] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.720732] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.720891] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.720893] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.720978] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.721103] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.721815] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.721817] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.721822] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.721841] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.721843] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.721882] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.722090] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.722384] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.722387] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.722564] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.722578] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.723346] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.723349] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.723365] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.723414] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.723419] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.723471] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.723678] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.723991] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.723997] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.724115] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.724324] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.724944] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.724946] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.724951] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.724961] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.724963] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.724975] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.725185] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.725468] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.725470] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.725555] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.725760] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.726446] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.726448] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.726452] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.726463] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.726464] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.726477] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.726653] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.726764] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.726767] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.726848] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.727039] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.727698] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.727700] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.727705] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.727724] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.727726] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.727766] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.727973] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.728282] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.728285] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.728392] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.728598] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.729325] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.729327] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.729335] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.729362] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.729366] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.729418] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.729557] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.729805] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.729810] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.729929] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.730070] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.730960] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.730963] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.730971] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.730988] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.730991] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.731007] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.731134] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.731350] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.731352] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.731437] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.731576] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.732330] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.732331] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.732336] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.732346] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.732348] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.732360] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.732499] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.732710] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.732713] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.732797] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.732938] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.733581] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.733583] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.733588] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.733607] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.733610] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.733650] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.733790] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.734035] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.734038] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.734145] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.734285] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.735084] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.735085] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.735094] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.735121] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.735126] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.735177] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.735312] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.735655] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.735662] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.735797] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.735836] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.749354] setting usb interface 0:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.749356] Re-using EP 5 in iface 0,1 
@ffff88027a074000
Aug 10 13:27:44 KAMDesktop kernel: [  178.749357] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.749371] Setting params for ep #5 
(type 0, 8 urbs), ret=0
Aug 10 13:27:44 KAMDesktop kernel: [  178.749372] match_endpoint_audioformats: 
(fmt @ffff88032febe500) score 2
Aug 10 13:27:44 KAMDesktop kernel: [  178.749374] Setting params for ep #84 
(type 0, 8 urbs), ret=0
Aug 10 13:27:44 KAMDesktop kernel: [  178.749375] Starting data EP 
@ffff88027a074000
Aug 10 13:27:44 KAMDesktop kernel: [  178.749477] Starting sync EP 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.763261] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.763264] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.763274] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.763296] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.763301] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.763320] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.763481] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.763699] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.763701] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.763789] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.763961] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.764758] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.764761] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.764768] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.764785] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.764790] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.764802] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.765017] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.765294] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.765296] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.765382] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.765589] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.766377] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.766379] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.766384] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.766403] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.766405] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.766445] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.766722] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.766860] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.766862] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.766970] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.767112] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.767901] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.767904] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.767920] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.767959] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.767963] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.768014] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.768154] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.768350] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.768359] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.768500] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.768589] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.769162] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.769164] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.769169] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.769183] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.769186] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.769200] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.769237] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.769318] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.769320] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.769404] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.769436] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.769911] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.769912] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.769918] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.769931] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.769934] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.769949] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.769955] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.770035] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.770037] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.770121] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.770128] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.770633] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.770634] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.770640] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.770660] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.770662] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.770702] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.770709] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.770810] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.770813] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.770920] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.770926] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.771510] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.771511] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.771520] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.771548] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.771552] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.771603] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.771611] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.771724] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.771729] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.771848] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.771857] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.772386] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.772387] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.772392] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.772403] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.772405] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.772417] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.772422] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.772500] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.772502] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.772587] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.772592] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.773145] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.773148] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.773155] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.773173] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.773176] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.773193] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.773198] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.773275] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.773277] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.773362] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.773366] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.773888] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.773890] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.773895] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.773914] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.773916] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.773957] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.773962] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.774064] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.774067] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.774174] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.774179] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.774890] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.774892] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.774900] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.774928] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.774933] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.774984] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.774993] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.775105] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.775111] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.775230] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.775239] Unable to change format on 
ep #84: already in use
Aug 10 13:27:44 KAMDesktop kernel: [  178.776516] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.776518] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.776528] Setting params for ep #84 
(type 0, 8 urbs), ret=0
Aug 10 13:27:44 KAMDesktop kernel: [  178.778519] setting usb interface 1:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.778521] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.778634] Setting params for ep #84 
(type 0, 8 urbs), ret=0
Aug 10 13:27:44 KAMDesktop kernel: [  178.779772] setting usb interface 0:1
Aug 10 13:27:44 KAMDesktop kernel: [  178.779774] Re-using EP 5 in iface 0,1 
@ffff88027a074000
Aug 10 13:27:44 KAMDesktop kernel: [  178.779775] Re-using EP 84 in iface 1,1 
@ffff8802e4fb8000
Aug 10 13:27:44 KAMDesktop kernel: [  178.779941] Setting params for ep #5 
(type 0, 8 urbs), ret=0
Aug 10 13:27:44 KAMDesktop kernel: [  178.779942] match_endpoint_audioformats: 
(fmt @ffff88032febe500) score 2
Aug 10 13:27:44 KAMDesktop kernel: [  178.779944] Setting params for ep #84 
(type 0, 8 urbs), ret=0
Aug 10 13:27:44 KAMDesktop kernel: [  178.779945] Starting data EP 
@ffff88027a074000
Aug 10 13:27:44 KAMDesktop kernel: [  178.780145] Starting sync EP 
@ffff8802e4fb8000
