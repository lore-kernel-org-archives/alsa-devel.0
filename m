From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: sigmadsp: Add check for return value
	of i2c_master_send
Date: Thu, 26 Nov 2015 14:04:49 +0100
Message-ID: <56570371.9020605@metafoo.de>
References: <1448542815-14197-1-git-send-email-pascal.huerst@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-194.synserver.de (smtp-out-208.synserver.de
 [212.40.185.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 54E582619FB
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 14:04:52 +0100 (CET)
In-Reply-To: <1448542815-14197-1-git-send-email-pascal.huerst@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: pascal.huerst@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/26/2015 02:00 PM, pascal.huerst@gmail.com wrote:
> From: Pascal Huerst <pascal.huerst@gmail.com>
> 
> i2c_master_send returns the number of bytes transmitted, which leads
> to an error in the firmware download function. Check for the return
> value and only return it directly, if it is an actual error number.
> 
> Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.
