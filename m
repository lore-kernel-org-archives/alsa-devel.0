From: "Harrod, John" <john.harrod@philips.com>
Subject: Triggering a DAPM widget event
Date: Tue, 25 Jan 2011 17:53:13 +0100
Message-ID: <39D4D143FC30524CAB784A72ADFECEEE34A0BC92CA@NLCLUEXM02.connect1.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	by alsa0.perex.cz (Postfix) with ESMTP id D1CDA103979
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 17:53:24 +0100 (CET)
Received: from mail31-db3 (localhost.localdomain [127.0.0.1])	by
	mail31-db3-R.bigfish.com (Postfix) with ESMTP id 42DDF380244	for
	<alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 16:53:22 +0000 (UTC)
Received: from DB3EHSMHS001.bigfish.com (unknown [10.3.81.250])	by
	mail31-db3.bigfish.com (Postfix) with ESMTP id D4CC6388063	for
	<alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 16:53:21 +0000 (UTC)
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

Hi all,



I have a program that uses the ALSA PCM interface to play sounds on an embedded system. Does anyone know how alsa-lib triggers a SND_SOC_DAPM_PRE_PMD widget event in DAPM core? On my system the event only gets called when the pcm is closed with snd_pcm_close(). Is there another function that can cause a widget shutdown?



Or is opening and closing the PCM every time I want to play a sound a good practice for saving power?



Regards,



John


________________________________
The information contained in this message may be confidential and legally protected under applicable law. The message is intended solely for the addressee(s). If you are not the intended recipient, you are hereby notified that any use, forwarding, dissemination, or reproduction of this message is strictly prohibited and may be unlawful. If you are not the intended recipient, please contact the sender by return e-mail and destroy all copies of the original message.
