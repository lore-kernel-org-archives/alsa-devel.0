From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: Need help implementing an external PCM/control
	plugin pair
Date: Fri, 16 Feb 2018 18:49:48 +0200
Message-ID: <73722bf0-9477-6a7e-3cb6-4bb72c1a3fde@gmail.com>
References: <0daf8a5e-c1dd-224e-52e7-7467d93aa045@gmail.com>
 <4deee929-ae8c-c330-d9d1-865c558a3b75@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f176.google.com (mail-wr0-f176.google.com
 [209.85.128.176])
 by alsa0.perex.cz (Postfix) with ESMTP id A0AB0267E69
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 17:49:51 +0100 (CET)
Received: by mail-wr0-f176.google.com with SMTP id b52so3510149wrd.10
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 08:49:51 -0800 (PST)
In-Reply-To: <4deee929-ae8c-c330-d9d1-865c558a3b75@sakamocchi.jp>
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
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/16/2018 12:38 PM, Takashi Sakamoto wrote:
> ALSA control core has a feature called as 'user-defined control element 
> set'. This will help your work, in my opinion. For example, alsa-lib 
> 'softvol' PCM plugin utilizes this feature to accomplishment 
> configurable volumes by the others[1]. This feature supports metadata by 
> TLV (Type-Length-Value) and eventing to subscribers as well.
> 
> The alsa-lib includes a test program for this feature, which I wrote[2]. 
> This may help your work by its actual code, I think[2].

Many thanks for your prompt reply Takashi!  I'll study your example code 
and report back, should I need further guidance.

D.
