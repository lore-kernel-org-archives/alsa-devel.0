From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [alsa-devel] /usr/share/alsa/alsa.conf :and file
	extention
Date: Mon, 17 Mar 2008 04:18:15 +0100
Message-ID: <47DDE2F7.7000904@keyaccess.nl>
References: <cab05a880803161957j7a82e04cma094afda62d5cdab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <cab05a880803161957j7a82e04cma094afda62d5cdab@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Alexander Indenbaum <alexander.indenbaum@gmail.com>
Cc: alsa-user <alsa-user@lists.sourceforge.net>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 17-03-08 03:57, Alexander Indenbaum wrote:

> I'm playing with embedded system without any hardware sound device. I'd like
> to grab sound from ALSA application, for instance Firefox displaying YouTube
> clip inside flash plugin and to store  output PCM stream into file on local
> disk. I got an advice to use File extension. So I defined following
> /usr/share/alsa/alsa.conf

Don't do it there. Use /etc/asound.conf or $HOME/.asoundrc ...

> pcm.default{
>         type
> file
>         file
> /tmp/pcm.out
> }

... and make it

pcm.!default {
         type    file
         slave   {
                 pcm     null
         }
         file    "/tmp/pcm.out"
}

Exactly why you need that slave definition I'm not sure either, but it seems 
you do. Also note that /tmp/pcm.out will be headerless PCM and is recreated 
for individual opens. I don't believe there's an append mode or anything 
(and you'd need to make sure that everyone plays the same format) so not 
toot sure if this is what you need to have a catch all audio-sink...

Rene.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
