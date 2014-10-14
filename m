From: Thomas Green <TGreen2@Sorenson.com>
Subject: disconnecting bluetooth device
Date: Tue, 14 Oct 2014 16:56:25 +0000
Message-ID: <C2BC44D770753C45AAAC42695FB5BE02AF653B0A@SLC-EXMB01.CORP.SRELAY.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from SLCv-EXEDGE01.Sorenson.com (mail.ccimprove.com [209.169.244.60])
 by alsa0.perex.cz (Postfix) with ESMTP id 62992260413
 for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2014 18:56:28 +0200 (CEST)
Content-Language: en-US
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

I am using gstreamer and bluez-alsa to connect to a Bluetooth headset.  I successfully connect to the device and can play audio from it.  The issue comes when the device disconnects.  Gstreamer lists these alsa errors:

0:00:25.312585875 24605 0x42430800 WARN                    alsa audio/pcm_bluetooth.c:247:playback_hw_thread: alsalib error: poll fd 1 revents 24
0:00:25.313233896 24605    0xd04f0 WARN                    alsa audio/pcm_bluetooth.c:835:bluetooth_playback_poll_revents: alsalib error: read error: Resource temporarily unavailable (11): Resource temporarily unavailable
(lots and lots of these until I terminate the application)

I've looked at the code for pcm_bluetooth.c, headset.c and pcm.c, and from what I can tell  it looks like what is happening is that the playback_hw_thread detects that the device has disconnected and gets a message back with POLLERR | POLLHUP.  In turn, when the bluetooth_playback_poll_revents is called, it can't read any further input.  But the io->state should be getting set to SND_PCM_STATE_DISCONNECTED.  From what I can see, I am guessing that what is happening is that above that is the bluetooth_playback_poll_revents keeps getting called without the io->state being checked to make sure whether or not the state is disconnected.  I haven't dug too deeply into the call stack higher than that, so, I'm not sure.  Is this what is happening, or is there something that I can do myself to miti
 gate this?  The default alsa installation is 1.0.25, but I've also built libasound 1.0.28, and I still get the same behavior.

Thanks...

Tom
