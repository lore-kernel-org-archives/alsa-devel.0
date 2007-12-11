From: "Christophe Osuna" <christophe.osuna@gmail.com>
Subject: Re: Capturing from Line and Mic simultaneously
Date: Tue, 11 Dec 2007 10:17:45 +0100
Message-ID: <b6251a620712110117y27db220fj3301924b47d8775b@mail.gmail.com>
References: <b6251a620712100820g3cf819l51879e1b3bbe3419@mail.gmail.com>
	<1197307681.4985.39.camel@razman.gruemaster.com>
	<b6251a620712110108j4266cc1cyc1f0b7620f157249@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 51E0D243BD
	for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2007 10:17:46 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so3983733wag
	for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2007 01:17:45 -0800 (PST)
In-Reply-To: <b6251a620712110108j4266cc1cyc1f0b7620f157249@mail.gmail.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2007/12/11, Christophe Osuna <christophe.osuna@gmail.com>:

> I guess I am misusing the API, but I don't know how to do it right.
> I've tried to use "hw:0" with four channels but that failed. I think I
> need to do something like opening "hw:0:0" with two channels and
> "hw:0:1" also with two channels, but I have no idea on how to do this.

Well, it seems that I have to open "hw:0,0" and "hw:0,1" (and not
"hw:0:0" and "hw:0:1"). I have tried to open one after the other and
it worked, it will probably also work for both at the same time.

I apologize for the noise on the mailing-list.
