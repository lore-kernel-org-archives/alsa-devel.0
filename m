From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] gcc6 narrowing error
Date: Tue, 21 Jun 2016 16:16:02 +0200
Message-ID: <57694C22.7060000@metafoo.de>
References: <1466410224-19466-1-git-send-email-normand@linux.vnet.ibm.com>
 <1466410224-19466-2-git-send-email-normand@linux.vnet.ibm.com>
 <53bac5ad-0ae4-5317-752f-ec8182a9796e@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id BF1162608EA
 for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2016 16:16:04 +0200 (CEST)
In-Reply-To: <53bac5ad-0ae4-5317-752f-ec8182a9796e@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Michel Normand <normand@linux.vnet.ibm.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/21/2016 01:21 PM, Clemens Ladisch wrote:
> Michel Normand wrote:
>> [   51s] Cus428Midi.cc:83:1: error: narrowing conversion of '-1' from 'int' to 'char' inside { } [-Wnarrowing]
>>
>> -	-1, -1, -1, -1, -1, -1
>> +	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1
> 
> The warning is wrong, because the value is a constant that fits into the
> narrower type.

Not if char is unsigned char, which it is on some platforms. Best is
probably to mark the array as explicitly signed or unsigned otherwise these
warnings will appear on one or the other platform.
