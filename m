From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Please remove documentation pointer
Date: Tue, 16 Jul 2002 01:14:40 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D32F4F0.9080006@boosthardware.com>
References: <Pine.LNX.4.21.0207151752530.24711-100000@mailserver.intern.bfad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: tomasz motylewski <T.Motylewski@bfad.de>
Cc: alsa-devel@lists.sourceforge.net, pbd@op.net
List-Id: alsa-devel@alsa-project.org

tomasz motylewski wrote:
>>Not true.
>>
>>Paul said that the document clearly states that it is unfinished and I 
>>said if you make any changes I will fix the document and put it up on 
>>the alsa server directly.
>>
>>The document has a lot of useful info but has become outdated.
>>  If you know what the problems are then submit a fix.
> 
> 
> 
> I did:
> 
> Date: Mon, 3 Jun 2002 21:47:07 +0200 (CEST)
> From: tomasz motylewski <tom@bfad.de>
> To: pbd@users.sourceforge.net
> Subject: wrong snd_pcm_open example code.
> 
> 
> On http://www.op.net/~pbd/alsa-audio.html#captureex you wrote:
> 
> capture_handle = snd_pcm_open (argv[1], SND_PCM_STREAM_CAPTURE, 0)
> 
> The real ALSA9 API is 
> 
> err = snd_pcm_open(&chandle, cdevice, SND_PCM_STREAM_CAPTURE, 0)
> 
> Could you please currect this?
> 
> In my opinion example programs are the best form od documentation, but not
> working examples are the worst form of misinformation.
> 
> ------------------
> 
> No answer.
> 

Like he said he is a busy person.

Is that all that is wrong with the document? I was under the impression 
there was more and was waiting for you to send it to the list so other 
people could verify it.

Paul - Are you ok with me putting the page on the alsa server as fully 
fledged ALSA documentation which other can contribute to without having 
to get your permission?

You have it licensed as GPL so I assume it is not a big deal to you if I 
do? Have you considered changing it to FDL instead?

-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
