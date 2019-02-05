From: Udo Eberhardt <udo.eberhardt@thesycon.de>
Subject: quirks patch for new T+A USB DAC
Date: Tue, 5 Feb 2019 17:08:51 +0100
Message-ID: <b2d6f671-1cee-231d-bf1c-a6a58e31076b@thesycon.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2EE12EDB801B0B27311730E8"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from routemea2.hes.trendmicro.eu (routemea2.hes.trendmicro.eu
 [52.58.63.14]) by alsa0.perex.cz (Postfix) with ESMTP id 49A562666B3
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 17:08:53 +0100 (CET)
Received: from 0.0.0.0_hes.trendmicro.com (unknown [192.168.14.59])
 by routemea2.hes.trendmicro.eu (Postfix) with SMTP id DDD2E45606C
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 16:08:51 +0000 (UTC)
Received: from mail.lan.thesycon.de (unknown [80.88.23.201])
 by relayemea3.hes.trendmicro.eu (TrendMicro Hosted Email Security) with ESMTP
 id 3A5C458C046
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 16:08:51 +0000 (UTC)
Received: from [192.168.1.106] (ue1.lan.thesycon.de [192.168.1.106])
 by mail.lan.thesycon.de (Postfix) with ESMTP id E1C9FE9C1C4
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 17:08:50 +0100 (CET)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------2EE12EDB801B0B27311730E8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

This is a patch for sound/usb/quirks.c which enables DSD support for a 
new T+A DAC for which we have developed the USB firmware. Here is a 
patch description:

This patch adds the T+A VID to the generic check in order to enable 
native DSD support for T+A devices. This works with the new T+A USB DAC 
model SD3100HV and will also work with future devices which support the 
XMOS/Thesycon style DSD format.


I hope you can apply this patch. Let me know if you need more info.

Thank you,
Udo


--------------2EE12EDB801B0B27311730E8
Content-Type: text/plain; charset=UTF-8;
 name="T+A_native_DSD_quirks.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="T+A_native_DSD_quirks.patch"

ZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9xdWlya3MuYyBiL3NvdW5kL3VzYi9xdWlya3MuYwpp
bmRleCBlZjY3ZDE5MTE3YzQuLmYzNzJjNjI0YmJmNCAxMDA2NDQKLS0tIGEvc291bmQvdXNi
L3F1aXJrcy5jCisrKyBiL3NvdW5kL3VzYi9xdWlya3MuYwpAQCAtMTU1Myw2ICsxNTUzLDcg
QEAgdTY0IHNuZF91c2JfaW50ZXJmYWNlX2RzZF9mb3JtYXRfcXVpcmtzKHN0cnVjdCBzbmRf
dXNiX2F1ZGlvICpjaGlwLAogCWNhc2UgMHgyMGIxOiAgLyogWE1PUyBiYXNlZCBkZXZpY2Vz
ICovCiAJY2FzZSAweDE1MmE6ICAvKiBUaGVzeWNvbiBkZXZpY2VzICovCiAJY2FzZSAweDI1
Y2U6ICAvKiBNeXRlayBkZXZpY2VzICovCisJY2FzZSAweDJhYjY6ICAvKiBUK0EgZGV2aWNl
cyAqLwogCQlpZiAoZnAtPmRzZF9yYXcpCiAJCQlyZXR1cm4gU05EUlZfUENNX0ZNVEJJVF9E
U0RfVTMyX0JFOwogCQlicmVhazsK
--------------2EE12EDB801B0B27311730E8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------2EE12EDB801B0B27311730E8--
