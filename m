From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: error: broken pipe
Date: Sun, 15 May 2005 11:01:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0505151101040.4270@pnote.perex-int.cz>
References: <1116089623.8003.2.camel@latitude>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1116089623.8003.2.camel@latitude>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Christian Konrad <konrad@in.tum.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 14 May 2005, Christian Konrad wrote:

> Hi!
> 
> what exactly does this error mean? This is just a sine-genrator and it
> uses the following code:
> 
> while( (pcmreturn = snd_pcm_writei(pcm_handle, data, frames)) < 0)
> {
> 			
> 	switch(pcmreturn)
> 	{
> 	case EBADFD:	cout << "EBADFD" << endl; break;
> 	case EPIPE:	cout << "Buffer underrun." << endl; break;
> 	case ESTRPIPE:	cout << "suspend. " << endl; break;	
> 	default: cout << snd_strerror(pcmreturn) << endl;
> 	}
> 			
> 	
> 	snd_pcm_prepare(pcm_handle);
> }
> 
> The only error I get is broken pipe (returned by snd_strerror).

It's correct. You should check for negative values (e.g. -EPIPE) in your 
switch statement.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
