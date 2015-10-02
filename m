From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Zoom R16/24 playback slient
Date: Fri, 2 Oct 2015 08:51:58 +0200
Message-ID: <alpine.DEB.2.02.1510020842020.12892@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1509292156390.6263@lnxricardw1.se.axis.com>
 <560B8481.1080304@laiskiainen.org>
 <alpine.DEB.2.02.1509300955510.12892@lnxricardw1.se.axis.com>
 <560B9EA9.2090304@laiskiainen.org>
 <alpine.DEB.2.02.1509302257330.24705@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id D7AA7260881
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2015 08:52:00 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1509302257330.24705@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Panu Matilainen <pmatilai@laiskiainen.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Wed, 30 Sep 2015, Ricard Wanderlof wrote:

> I did a small bit of experimenting, and as far as I can tell, playback =

> seems to hang the device so it becomes completely unresponsive and needs =

> to be restarted.

Actually, after a bit more experimenting, the R16 actually wakes up from =

its unresponsive state after a couple of minutes, at least when playing a =

small file. After that it seems to behave as before.

I'm learning USB and USB-audio at the same time so progress is slow.

Installed the Zoom Windows driver on a Win7 box, followed by the bundled =

DAW software (Cubase 6 LE), in order to dump the USB data to see what was =

going on, using USBPcap.

Captured the corresponding traffic in Linux using usbmon and Wireshark.

I transferred the Windows pcap dumps to Linux for subsequent analysis in =

Wireshark.

It was getting late so I didn't do more than a cursory look. I noted that =

the packet format is very different between Windows and Linux, but if =

that's due to the different capture methods I don't know. For the USBPcap =

dump each Isochronous frame contains a number of isochronous packets, =

whereas the dump I do on Linux just lists the payload as 'captured =

isochronous data' or somesuch. Even basic things such as the packet =

lengths don't match, but I also noted that USBPcap seems to insert =

metadata into the frames (to ease decoding?) Got to research that more.

I did conclude however that when playing back to the R16 there seems to be =

an isochronous packet flow going on with data from both ends of the =

link (again, I need to read up what really to expect). What is odd is that =

in Linux, the final packet from the host is a SET CONFIGURATION, and the =

R16 seems to take about 5 seconds to respond to it. I thought 5 seconds =

was supposed to be a general timeout when waiting for responses in USB, =

not the maximum time before a device can respond. But perhaps the R16 =

thinks it's in a mode where it's expecting more data from the host and =

thus times out when receiving a request its not expecting and actually =

goes ahead and processes the same request.

My next step may be to use USBPcap to capture the data in Linux too so I =

get comparable dumps. And do read up on USB audio documentation...

/RIcard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
