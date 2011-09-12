From: Raymond Toy <rtoy@google.com>
Subject: Re: Determining the plugins being used?
Date: Mon, 12 Sep 2011 14:04:49 -0700
Message-ID: <CAE3TgXEWbnacMSbfgor4gk54ADDY60prBHu4mX3aSLmYDO6AsQ@mail.gmail.com>
References: <CAE3TgXGk9uaK0ESwUj2OGXKjBhRpi8tUgQXRT8GOMHLhX8ELGg@mail.gmail.com>
	<4E6E6C28.1070009@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 37D2924399
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 23:04:56 +0200 (CEST)
Received: from hpaq12.eem.corp.google.com (hpaq12.eem.corp.google.com
	[172.25.149.12]) by smtp-out.google.com with ESMTP id p8CL4t1l022850
	for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2011 14:04:55 -0700
Received: from yib18 (yib18.prod.google.com [10.243.65.82])
	by hpaq12.eem.corp.google.com with ESMTP id p8CL3O2p019488
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2011 14:04:54 -0700
Received: by yib18 with SMTP id 18so3651686yib.23
	for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2011 14:04:49 -0700 (PDT)
In-Reply-To: <4E6E6C28.1070009@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 12, 2011 at 1:31 PM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Raymond Toy wrote:
> > Is there a way to determine the plugins being used?
>
> Not really.  snd_pcm_type() gives you the topmost plugin's type.
>
>
>
Bummer.  So the only hacky way is to look at the output of snd_pcm_dump,
then?

I will look into other ways to determine what I need to know about the
underlying audio interface.

Thanks,

Ray
