From: Josh Green <jgreen@users.sourceforge.net>
Subject: Re: Broken pipe mystery
Date: 08 Feb 2003 23:36:45 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1044776209.1992.7.camel@sprekhole>
References: <058801c2cf5b$d4f1dfb0$0100a8c0@Pblaptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <058801c2cf5b$d4f1dfb0$0100a8c0@Pblaptop>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pete Barnard <petebarnard@tiscali.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2003-02-08 at 02:21, Pete Barnard wrote:
> I am using ALSA 0.9.0rc7 and Red Hat Linux 7.2.  My sound card is a CS461x.
> My computer is a reasonably powerful beast with 512M of RAM and 1Gig clock
> speed.
> I have written a simple capture program which reads interleaved samples from
> the sound card and goes around in a continuous while(1) loop.  My program
> works perfectly - until it crashes after several hours with the message:
> 
> "read from audio interface failed: broken pipe".
> 
> I have narrowed it down to the following piece of code.  The size of buf is 256 (shorts). Why would the snd_pcm_readi suddenly (randomly?) fail with a broken pipe???  Any ideas or suggestions would be greatly appreciated as I'm struggling with this
> annoying (and difficult to debug)  problem.
> 
> Regards,
> 
> Pete
> 
> while (1)
> {
>     if ((err = snd_pcm_readi(capture_handle,buf,128)) != 128
>     {
>         // this is where it fails after several hours of working
> successfully
>         cout << "read from audio interface failed: " << snd_strerror(err) <<
> endl;
>         exit(1);
>     }
> }
> 

If I remember correctly the EPIPE error code is returned when an xrun
occurs. In the case of a read it would be a buffer overrun. Your code
should check for this return value and I believe you have to start the
stream again with "snd_pcm_prepare". Check out the ALSA site for HOWTOs
and the like. Cheers.
	Josh Green



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
