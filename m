From: "Ted T. Logan" <tedtheologian@gmail.com>
Subject: how to set default alsa pcm device as bluetooth,
 so i can play flash  in firefox to bluetooth headset?
Date: Mon, 16 Feb 2009 11:37:19 -0600
Message-ID: <1234805839.20503.2.camel@home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.152])
	by alsa0.perex.cz (Postfix) with ESMTP id B4CF0243E0
	for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2009 18:37:22 +0100 (CET)
Received: by yx-out-1718.google.com with SMTP id 36so1228774yxh.2
	for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2009 09:37:21 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 I did this, but no go:

pcm.bluetoothstereo {
   type bluetooth
     device 00:18:E4:0C:4D:17 #headset
   profile "auto"
}

pcm.!default
{
        type plug
        slave.pcm "bluetoothstereo"

}




I can do things like
mplayer -ao alsa:device=bluetoothstereo

with no problem, and I hear fine through the headset.  However, I'd like
to be able to play flash audio from firefox through the headset.  What
am i doing wrong?

rpmq bluez
bluez-hcidump-1.42-2.fc10.i386
bluez-libs-4.22-2.fc10.i386
bluez-4.22-2.fc10.i386
bluez-gstreamer-4.22-2.fc10.i386
bluez-gnome-analyzer-1.8-11.fc10.i386
bluez-libs-devel-4.22-2.fc10.i386
bluez-gnome-1.8-11.fc10.i386
bluez-alsa-4.22-2.fc10.i386
bluez-cups-4.22-2.fc10.i386
