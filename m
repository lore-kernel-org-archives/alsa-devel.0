From: Andy Wingo <wingo@pobox.com>
Subject: Re: Example app source code or docs needed to help me do mmap.
Date: Fri, 26 Apr 2002 21:34:43 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020427013443.GD664@jesus>
References: <3CC9F106.8020806@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3CC9F106.8020806@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 27 Apr 2002, James Courtier-Dutton wrote:

> Can someone point me to an example alsa app doing mmap ?

I like the implementation in jack's alsa_driver. It is tricky code
though (just MHO, after having ported it to a gstreamer alsa plugin) --
the write() api is of course much easier.

regards,

wingo.

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
