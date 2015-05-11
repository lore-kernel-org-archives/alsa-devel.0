From: sylvain.bertrand@gmail.com
Subject: Re: USB-Audio.conf routing and dmix
Date: Mon, 11 May 2015 19:57:34 +0000
Message-ID: <20150511195734.GA12233@freedom>
References: <20150509002017.GB18945@freedom>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
 [209.85.212.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F2FE26072A
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 21:57:47 +0200 (CEST)
Received: by wief7 with SMTP id f7so94661520wie.0
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 12:57:47 -0700 (PDT)
Received: from localhost (spybox.legeek.net. [88.188.175.165])
 by mx.google.com with ESMTPSA id ew10sm1240124wic.22.2015.05.11.12.57.46
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 May 2015 12:57:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150509002017.GB18945@freedom>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, May 09, 2015 at 12:20:17AM +0000, sylvain.bertrand@gmail.com wrote:
> Hi,
> 
> I have a bose USB audio 5.1 device, a generic USB audio device.
> 
> I noticed that the proper channels routing was missing from the default generic
> USB pcm, but dmix was used. And for the surround pcms I noticed it was the
> other way around!
> 
> I did modify the default pcm to include a routing plugin. I put 8 channels in
> the routing plugin. I guess the proper way would be to detect the hw card
> number of channels and select a route plugin configuration with the correct
> count of channels (maybe their is a function to get that info?).
> 
> I linked the surround51 and surround71 pcms with the 'disable-able' dmix
> section from the default pcm.
> 
> I did not touch the surround40* pcms, surround pcms which are specific to some
> cards and the iec958 ones.
> 
> http://filebin.ca/214UTT8fBnUm/USB-Audio.conf

did I post on the right mailing list for alsa-lib default configuration improvment?

-- 
Sylvain
