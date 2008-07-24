From: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH] Clean up ASOC functions to support 32b
	values instead of 16b
Date: Wed, 23 Jul 2008 22:55:19 -0500
Message-ID: <ed82fe3e0807232055t3ab09348x789959c834784ca2@mail.gmail.com>
References: <20080723233635.6900.55269.stgit@terra>
	<ed82fe3e0807231841s2489781fr7515cd0bd0195586@mail.gmail.com>
	<9e4733910807231908s449922adtd24f911d467d51fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D8A82437D
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 05:55:20 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 36so1533885wra.24
	for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2008 20:55:19 -0700 (PDT)
In-Reply-To: <9e4733910807231908s449922adtd24f911d467d51fd@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 23, 2008 at 9:08 PM, Jon Smirl <jonsmirl@gmail.com> wrote:

>> Please use "unsigned int" instead of "uint".
>
> Why? uint is a standard Linux kernel definition. I almost made them all u32.

For consistency.  The rest of the source file doesn't use the
abbreviated types.  Also, sized integer types like u32 should only be
used when the variable must have a certain number of bits, so you
shouldn't use u32 as a general purpose integer type.

-- 
Timur Tabi
Linux kernel developer at Freescale
