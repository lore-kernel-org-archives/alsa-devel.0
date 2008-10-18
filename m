From: Erik de Castro Lopo <mle+la@mega-nerd.com>
Subject: snd_pcm_sw_params_get_xfer_align deprecated?
Date: Sat, 18 Oct 2008 21:43:32 +1100
Message-ID: <20081018214332.10729096.mle+la@mega-nerd.com>
Reply-To: alsa-devel@alsa-project.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from outbound.icp-qv1-irony-out2.iinet.net.au
	(outbound.icp-qv1-irony-out2.iinet.net.au [203.59.1.107])
	by alsa0.perex.cz (Postfix) with ESMTP id 46FA6243DB
	for <alsa-devel@alsa-project.org>;
	Sat, 18 Oct 2008 12:43:53 +0200 (CEST)
Received: from hendrix (hendrix [192.168.200.99])
	by hendrix.mega-nerd.net (Postfix) with SMTP id C6E5DAB12B
	for <alsa-devel@alsa-project.org>; Sat, 18 Oct 2008 21:43:32 +1100 (EST)
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

Hi all,

I've got some code that gives me a waring that the above function
is deprecated. What should I do:

  a) Call some other function? If so which one?
  b) Just drop the call to that function and everything will
     continue to work as it should?
  c) Something else?

Cheers,
Erik
-- 
-----------------------------------------------------------------
Erik de Castro Lopo
-----------------------------------------------------------------
"The very definition of hell is having to maintain someone
else's Perl code." -- Anonymous
