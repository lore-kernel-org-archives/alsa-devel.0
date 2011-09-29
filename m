From: "Gupta, Suresh" <Suresh.Gupta@lsi.com>
Subject: LSI HDA Modem is not working on HP new Laptop which
 has IDT 7605 HDA codec and REDHAT installed on it with ALSA ver 1.0.24.
Date: Thu, 29 Sep 2011 10:51:28 +0530
Message-ID: <B2FD678A64EAAD45B089B123FDFC3ED70166618A4C@inbmail01.lsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog101.obsmtp.com (na3sys009aog101.obsmtp.com
	[74.125.149.67])
	by alsa0.perex.cz (Postfix) with ESMTP id C35A7103811
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Sep 2011 07:21:36 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Modem receive unwanted data on stream 0 even stream is not open by any device.
Stream 0 was acquired by IDC 7605 and this codec keep sending something even after closing the stream.

On further investigation I found ALSA ver 1.0.24 have new fix "Make converter setups sticky" which changes the semantics of snd_hda_codec_cleanup_stream() not to clean up the stream at that moment but delay the action. This is the reason why Modem getting some unwanted data and stop working.

To resolve this issue we need to enable "no_sticky_stream" for these IDT codec. The fix is like putting one line of code "codec->no_sticky_stream =1;" at the end of function "patch_stac92hd83xxx" in file "/sound/pci/hda/patch_sigmatel.c".

As I am not much aware of the fix "Make converter setups sticky" and also not know the side effects of above mention fix, please analyze and fix the issue properly.

Thanks
SuresH
