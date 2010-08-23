From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: Implementing full-duplex realtime sound processor
Date: Mon, 23 Aug 2010 10:50:49 +0100
Message-ID: <AANLkTimzWczB5XGN=16QaMDkd_mvW8bwK_14Bbpci+JL@mail.gmail.com>
References: <1282495236.8223.7.camel@koffer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EBF424498
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Aug 2010 11:50:50 +0200 (CEST)
Received: by qyk9 with SMTP id 9so5620630qyk.17
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2010 02:50:49 -0700 (PDT)
In-Reply-To: <1282495236.8223.7.camel@koffer>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Gregory Bonik <gregory@bonik.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 22 August 2010 17:40, Gregory Bonik <gregory@bonik.org> wrote:
> Hi there,
>
> I'm trying to implement a full-duplex realtime sound processing app.
> I.e., it should capture a stream from a soundcard, do some processing on
> it and play it with minimal latency.
>
> I don't want to use JACK or any other higher-level API, so I'm looking
> for the best way to do it directly with ALSA. So far I've discovered
> three approaches:
>

Why don't you want to use JACK. It is a perfect fit for what you are
trying to do, and it solves a LOT of problems that you don't yet know
you will run into.
