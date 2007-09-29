From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Re: Alsa 1.0.15rc2 and oops with Dell M1210
Date: Sat, 29 Sep 2007 00:46:31 -0300
Message-ID: <200709290046.31995.herton@mandriva.com.br>
References: <200709282352.01789.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 23520103838
	for <alsa-devel@alsa-project.org>;
	Sat, 29 Sep 2007 05:46:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 8C8F917B6F
	for <alsa-devel@alsa-project.org>; Sat, 29 Sep 2007 00:46:36 -0300 (BRT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id MLZ1qiFraQ7X for <alsa-devel@alsa-project.org>;
	Sat, 29 Sep 2007 00:46:34 -0300 (BRT)
Received: from [192.168.2.2] (200-103-138-174.ctame705.dsl.brasiltelecom.net.br
	[200.103.138.174])
	by perninha.conectiva.com.br (Postfix) with ESMTP id DE9A417B32
	for <alsa-devel@alsa-project.org>; Sat, 29 Sep 2007 00:46:33 -0300 (BRT)
In-Reply-To: <200709282352.01789.herton@mandriva.com.br>
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

On Friday 28 September 2007 23:52:01 you wrote:
> stac92xx_mux_enum_info received uinfo == NULL (where uinfo comes from?) and
> passed it to
> snd_hda_input_mux_info.

Er, forget about uinfo, I mean input_mux doesn't seem to be set somewhere.

--
[]'s
Herton
