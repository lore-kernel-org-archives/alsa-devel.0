From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] gcc6 narrowing error
Date: Tue, 21 Jun 2016 13:21:40 +0200
Message-ID: <53bac5ad-0ae4-5317-752f-ec8182a9796e@ladisch.de>
References: <1466410224-19466-1-git-send-email-normand@linux.vnet.ibm.com>
 <1466410224-19466-2-git-send-email-normand@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 9A0B42604D1
 for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2016 13:21:44 +0200 (CEST)
In-Reply-To: <1466410224-19466-2-git-send-email-normand@linux.vnet.ibm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michel Normand <normand@linux.vnet.ibm.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Michel Normand wrote:
> [   51s] Cus428Midi.cc:83:1: error: narrowing conversion of '-1' from 'int' to 'char' inside { } [-Wnarrowing]
>
> -	-1, -1, -1, -1, -1, -1
> +	(char)-1, (char)-1, (char)-1, (char)-1, (char)-1, (char)-1

The warning is wrong, because the value is a constant that fits into the
narrower type.


Regards,
Clemens
