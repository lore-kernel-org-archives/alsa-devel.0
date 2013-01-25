From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: =?windows-1252?q?ASoC=3A_codec_jz4740=3A_Failed_to_b?=
 =?windows-1252?q?uild_for_use_of_=22=91devm=5Fioremap=5Fresource=22_on_br?=
 =?windows-1252?q?anch_=22for-next=22?=
Date: Fri, 25 Jan 2013 08:23:00 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82E3694@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 6851D261703
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2013 09:23:06 +0100 (CET)
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

Hi,

I failed to build the branch =93for-next=94. Here is error information:
sound/soc/codecs/jz4740.c: In function =91jz4740_codec_probe=92:
sound/soc/codecs/jz4740.c:364:2: error: implicit declaration of function =
=91devm_ioremap_resource=92 [-Werror=3Dimplicit-function-declaration]
sound/soc/codecs/jz4740.c:364:7: warning: assignment makes pointer from int=
eger without a cast [enabled by default]

It seems the newly introduced =93devm_ioremap_resource=94 is to replace dev=
m_request_and_ioremap().
But its definition are absent from the kernel. I cannot find where it=92s d=
efined, neither in device.h nor in io.h .


Thanks
Mengdong
