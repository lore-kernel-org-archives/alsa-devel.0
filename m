From: Zbigniew Baniewski <zb@ispid.com.pl>
Subject: Re: Audigy: recording level much too low (microphone)
Date: Fri, 10 Aug 2007 19:53:14 +0200
Message-ID: <20070810175314.GA5250@sarge.my.own.domain.no-net>
References: <20070810110217.GA7011@sarge.my.own.domain.no-net>
	<1186768407.3057.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from v05705.home.net.pl (v05705.home.net.pl [212.85.118.117])
	by alsa0.perex.cz (Postfix) with SMTP id 43BEE243AC
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Aug 2007 19:53:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1186768407.3057.10.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Zubaj <pzubaj@marticonet.sk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 10, 2007 at 07:53:27PM +0200, Peter Zubaj wrote:

> Replace 0x0000 with value you want. 0x0000 is gain value - 0x0000 is
> minimum and I think it is current default - 0 dB
> 0x0101 is 1.5 dB
> 0x0202 is 3 dB
> ....
> 0x0f0f is max - 22.5 dB
> step is 1.5 dB

Yes! Thanks a lot! :) I realize, it's a "workaround" rather than real
solution, but this made Audigy suitable for VOIP (I tried the highest value
of 0x0f0f).

I've got a feeling, it could be even set in release this way for all the
Audigy owners, until the final solution of DSP-related issues will take
place, because it doesn't seem to spoil anything (although I didn't made
much testing of all the available options yet). Or it could be switched on
by some special option: like at "configuration" stage before compilation,
or perhaps even as the additional module parameter.
-- 
				pozdrawiam / regards

						Zbigniew Baniewski
