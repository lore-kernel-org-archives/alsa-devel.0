From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: Re: [PATCH] cs4231-lib: improved waiting after
 mce_down (2nd rev)
Date: Tue, 11 Sep 2007 06:52:18 +0200
Message-ID: <20070911065218.af0fccd1.krzysztof.h1@gmail.com>
References: <20070909221131.06372eb2.krzysztof.h1@gmail.com>
	<s5hbqcaqkb8.wl%tiwai@suse.de>
	<20070911004010.b9114b3e.krzysztof.h1@gmail.com>
	<46E5C89E.4010607@gmail.com> <s5hejh6ktk8.wl%tiwai@suse.de>
	<s5hd4wqkt5a.wl%tiwai@suse.de> <46E5E402.40906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F01D2443D
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Sep 2007 06:45:29 +0200 (CEST)
Received: by hu-out-0506.google.com with SMTP id 16so592667hue
	for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2007 21:45:28 -0700 (PDT)
In-Reply-To: <46E5E402.40906@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 11 Sep 2007 02:40:34 +0200
Rene Herman <rene.herman@gmail.com> wrote:

> On 09/11/2007 01:17 AM, Takashi Iwai wrote:
> 
> Works for me on ISA CS4231 (behind an AZT1605). Earlier Krzysztof suggested 
> that 2 ms may be optimum, but I'll leave that upto him.
> 

The 2ms is optimal before the loop. Inside the loop the less the better.

Regards,
Krzysztof
