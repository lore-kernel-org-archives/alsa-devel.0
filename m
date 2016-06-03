From: Timur Karaldin <karaldin@mcsplus.ru>
Subject: ASoC: TLV320AIC3x changing suspend delay time
Date: Fri, 3 Jun 2016 16:22:39 +0300
Message-ID: <3cde8b0c-3b99-d61f-7c0a-c18621fbc4bb@mcsplus.ru>
References: <14D46C39-5FDF-40DD-A16B-2DA7BDE930CB@latencyzero.com>
 <5714FEE5.5070002@ti.com>
 <5D6815AB-B3DF-4F4F-BC0D-33612A202975@latencyzero.com>
 <5715D775.8030303@ti.com>
 <DFF31AA6-67AF-429A-B108-6544180038F2@latencyzero.com>
 <5715E008.9000500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp21.mail.ru (smtp21.mail.ru [94.100.179.250])
 by alsa0.perex.cz (Postfix) with ESMTP id 050E82612DF
 for <alsa-devel@alsa-project.org>; Fri,  3 Jun 2016 15:22:46 +0200 (CEST)
In-Reply-To: <5715E008.9000500@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi!

Could you help me to control delay time for suspend and power down codec. Because of 
HW problem for my board I need to warm reset codec each time I'm doing close/open 
ALSA device. Because of suspend delay the codec's driver didn't power off chip until 
SW waits at least about 5 seconds between close and open. Thank you for any help.

Best regards,
Timur Karaldin
