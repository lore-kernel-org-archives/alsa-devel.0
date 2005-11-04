From: Giorgio Padrin <giorgio@mandarinlogiq.org>
Subject: Audio support for codec Philips UDA1380
Date: Fri, 4 Nov 2005 12:01:01 +0100
Message-ID: <200511041201.01260.giorgio@mandarinlogiq.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: alsa-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Hi all,

I want to contribute code to support audio codec Philips UDA1380.
Download from: "http://www.mandarinlogiq.org/PXA2xx i2Sound/"

Clean write for ALSA and kernel 2.6 with full power optimizations at subchip 
level, enabling hw blocks on need. Looking around in the kernel, this seems 
to be a novelty among sound drivers, that run commonly in an 
all-always-powered-up manner.

See h2200_audio (also on the site) for a sample glue module, that support the 
audio of an iPAQ h2200 handheld, using it together with a complementary module 
for the Intel PXA2xx I2S audio.

I wish to know whether there are other similar works in development.

Giorgio 



-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
