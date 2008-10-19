From: Markus Grabner <grabner@icg.tugraz.at>
Subject: alsa + resampler + jack: possible?
Date: Sun, 19 Oct 2008 02:38:53 +0200
Message-ID: <200810190238.53805.grabner@icg.tugraz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	by alsa0.perex.cz (Postfix) with ESMTP id 640DC103895
	for <alsa-devel@alsa-project.org>;
	Sun, 19 Oct 2008 02:39:14 +0200 (CEST)
Received: from server.w42.at (server.w42.at [91.114.29.43])
	by bsmtp.bon.at (Postfix) with ESMTP id 90290CDF84
	for <alsa-devel@alsa-project.org>;
	Sun, 19 Oct 2008 02:38:55 +0200 (CEST)
Received: from mark.home.at (mark.w42.at [192.168.1.3])
	by server.w42.at (Postfix) with ESMTP id D78E9B96BE
	for <alsa-devel@alsa-project.org>;
	Sun, 19 Oct 2008 02:38:54 +0200 (CEST)
Content-Disposition: inline
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


	Hi all!

    A while ago I started development of an ALSA driver for a device which 
natively only supports a sampling rate of 39062.5 Hz and 24 bit samples (see 
http://www.tanzband-scream.at/line6). The ALSA rate plugin does a perfect job 
for using this device with standard applications (such as xmms) to play audio 
files at "conventional" sample rates (e.g., 44.1 kHz) with a configuration 
like this:

pcm.resampler {
    type rate
    slave {
	pcm hw:1
	format S24_3LE
	rate 39062
    }
    converter "samplerate"
}

However, this doesn't work for jack since jack requires a power-of-two period 
size, and ALSA can't find an integer period size for the raw device such that 
the target rate is met with sufficient precision. An example: the jack daemon 
can't be started with period size 512 and sample rate 48000 Hz, but it works 
for 47961 Hz since

512 * 39062.5 / 48000 = 416.666... ~= 417 bytes
512 / 417 * 39062.5 = 47961.63 ~= 47961 Hz

When using this approach together with other audio data from a 48 kHz source, 
they would drift apart over time, which basically renders the alsa+jack setup 
useless for this device. I understand that resampling is easier to implement 
if the sample rate ratio equals the ratio of the (integer) period sizes of 
client and slave, but at least the underlying libsamplerate has no such 
restriction. I tried to find the relevant pieces in the ALSA source code 
(pcm_rate.c), but I'm not sure where these calculations are done and how much 
effort it would be to support arbitrary sample rate ratios for the resampler. 
Can this be done in a plugin, or does it require modifications in the ALSA 
library code base? Could the developers please give a few hints on that?

	Thanks & kind regards,
		Markus


-- 
Markus Grabner - Computer Graphics and Vision
Graz University of Technology, Inffeldgasse 16a/II, 8010 Graz, Austria
Phone: +43/316/873-5041, Fax: +43/316/873-5050
WWW: http://www.icg.tugraz.at/Members/grabner
