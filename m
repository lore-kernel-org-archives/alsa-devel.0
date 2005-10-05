From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: What and where is the function sa1100_dma_set_callback()??
Date: Wed, 5 Oct 2005 14:35:09 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0510051430300.3797-100000@studcom.urz.uni-halle.de>
References: <715d90900510050036o4c5736bbid9cfc167310420e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <715d90900510050036o4c5736bbid9cfc167310420e1@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: boku <boku0712@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

boku wrote:
>    I'm studying the sa11xx-uda1341.c. I couldn't find the function
> sa1100_dma_set_callback() called in the function, audio_dma_request().
> Where and what is the sa1100_dma_set_callback() for?

It's an obsolete function that used to set what now is the third
parameter of sa1100_request_dma().


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
