From: Benjamin Gorman <b.gorman@dundee.ac.uk>
Subject: Playstation Eye won't accept rate greater than 16k,
	48k device.
Date: Mon, 10 Mar 2014 21:43:29 +0000
Message-ID: <c9a968388d984443b7eb98f32b0b3c28@DBXPR04MB304.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3lp0084.outbound.protection.outlook.com [213.199.154.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 1123E2607BB
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 22:43:32 +0100 (CET)
Content-Language: en-GB
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

Hello,


I'm working with a playstation eye and I'm attempting to grab the raw audio in order to perform some processing using it's 4 channel microphone array.


It's listed by the vendor as being a 48khz device. Using Audacity on OSX I can record 4 channels at 44,100hz.


However, under linux (raspberry pi running debian) I can only record in 16khz using ALSA.


arecord -vv /dev/null -r 16000 -f S16_LE -c 4 -D iec958:CARD=CameraB409241,DEV=0 /dev/null < /dev/null


Any higher rate won't be accepted. I tried this using the ALSA C API and also under the PortAudio API. Both without luck.


Any ideas on how to patch the driver in order to allow for 44100hz recording? The device is clearly capable of it.


Regards,


Benjamin

The University of Dundee is a registered Scottish Charity, No: SC015096
