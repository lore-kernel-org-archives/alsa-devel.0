From: "Alex Lau" <lau2468@hotmail.com>
Subject: Re: ALSA API
Date: Sun, 04 Jan 2004 17:44:38 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Law10-F99ez3M2L618r00071fef@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: g_sf@zewt.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


The sample in the tutorial use command line argument, so I try to follow  
the sine wave generation code in this url
http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2pcm_8c-example.html

it use
char *device = "hw:0,0";
....

I try to pass the string "default" to the function, but still get an error 
-2 (No such file or directory)

>On Sun, Jan 04, 2004 at 09:19:16AM -0800, Alex Lau wrote:
> > I try to run the minimal playback program from the tutorial found in the
> > alsa web site,
> >
> > snd_pcm_t  *handle;
> > char  *device = "hw:0,0";
>
>Shouldn't the tutorial be using "default", if that's what programs that
>don't care should be using?  (The arguments used in tutorials are what
>most applications are going to use.)
>
>--
>Glenn Maynard
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: IBM Linux Tutorials.
>Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
>Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
>Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel

_________________________________________________________________
MSN 8 helps eliminate e-mail viruses. Get 2 months FREE*.  
http://join.msn.com/?page=features/virus&pgmarket=en-ca&RU=http%3a%2f%2fjoin.msn.com%2f%3fpage%3dmisc%2fspecialoffers%26pgmarket%3den-ca



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
