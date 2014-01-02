From: Guillaume Desclaux <guillaume@desclaux.fr>
Subject: Re: hda problem on Gigabyte GA-Z87X-UD3H motherboard
Date: Thu, 02 Jan 2014 12:43:52 +0100
Message-ID: <52C550F8.6030202@desclaux.fr>
References: <52B838F4.3030701@desclaux.fr>
 <CAN8cciYaQaYCzT4NPnfE3OC4Fk78kndEPOmnOuhPBG4K9_MTGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail01.one2net.net (mail5.one2net.net [5.39.67.68])
 by alsa0.perex.cz (Postfix) with ESMTP id B034526171F
 for <alsa-devel@alsa-project.org>; Thu,  2 Jan 2014 12:43:54 +0100 (CET)
In-Reply-To: <CAN8cciYaQaYCzT4NPnfE3OC4Fk78kndEPOmnOuhPBG4K9_MTGQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This motherboard uses ALC898 with a DRV632 which is a Texas Instruments 
Line driver/AMP. This line driver/AMP only works on the front panel 
headphone output and you must use the internal header to get it.

Maybe it's the source of this strange behavior ?

I don't know if it's helpful for you...
