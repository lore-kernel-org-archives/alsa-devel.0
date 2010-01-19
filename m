From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Can we add optional parameters in	snd_pcm_hw_params
Date: Tue, 19 Jan 2010 13:37:58 +0000
Message-ID: <20100119133757.GA2392@sirena.org.uk>
References: <358341421001190535o616ff737m15851b124402950e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B7CA24370
	for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2010 14:37:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <358341421001190535o616ff737m15851b124402950e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raul Xiong <raulxiong@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 19, 2010 at 09:35:10PM +0800, Raul Xiong wrote:

> Basically, my requirment is: There are two modes: ModeA and ModeB. I'd like
> application to set this mode before it begin playing. If you have other
> better methods to reach this requirment, it's also welcome. Thanks.

Why not just expose a regular control for this and store the value in
your private data?
