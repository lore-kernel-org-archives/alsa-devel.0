From: Abramo Bagnara <abramo.bagnara@tin.it>
Subject: Re: [alsa-cvslog] CVS: alsa-lib/src/pcm pcm.c,1.271,1.272
Date: Mon, 01 Mar 2004 22:17:32 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4043A86C.4000406@tin.it>
References: <E1AxjBQ-00059u-Nx@sc8-pr-cvs1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1AxjBQ-00059u-Nx@sc8-pr-cvs1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela ha scritto:
> Update of /cvsroot/alsa/alsa-lib/src/pcm
> In directory sc8-pr-cvs1.sourceforge.net:/tmp/cvs-serv19814
> 
> Modified Files:
> 	pcm.c 
> Log Message:
> Fixed return comment for *near() functions
> 
> Index: pcm.c
> ===================================================================
> RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm.c,v
> retrieving revision 1.271
> retrieving revision 1.272
> diff -u -r1.271 -r1.272
> --- pcm.c	23 Feb 2004 10:34:17 -0000	1.271
> +++ pcm.c	1 Mar 2004 08:53:50 -0000	1.272
> @@ -3418,7 +3418,7 @@
>   * \param pcm PCM handle
>   * \param params Configuration space
>   * \param val target channels count, returned chosen channels count
> - * \return chosen channels count
> + * \return 0 otherwise a negative error code if configuration space would become empty

*near() functions semantic cannot return error by design.

Taken for granted that configuration space on entry of function is not 
empty how it can become empty if I ask for *nearest* value?

Obviously at least one configuration exists, then in the worst case such 
value is returned.

Do you agree?


-- 
Abramo Bagnara                       mailto:abramo.bagnara@tin.it

Opera Unica                          Phone: +39.0546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
