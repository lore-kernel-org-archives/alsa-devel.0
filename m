From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: Re: PCM hw mixing with volume
Date: Thu, 11 Mar 2004 01:15:29 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1078982128.1838.72.camel@localhost>
References: <XFMail.20040310104621.pochini@shiny.it>
	 <1078928193.18054.247.camel@renegade> <404F62B1.30206@superbug.demon.co.uk>
Reply-To: manuel.jander@mat.utfsm.cl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <404F62B1.30206@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,


> What about 7.1 surround sound channels. All your suggestions only assume 
> 2 PCM channels.

Lets clarify something: A 3D stream is one mono stream, that is split
into all the necesary channels with the corresponding processing for
whatever amount of speaker / headphones you have, to get the single
audio channel spatialized. If we are talking about 5.1, 7.1 or 69.2,
that fact should be irrelevant for the API. The particular driver must
take care to make the audio stream sound like if it comes from the right
or left. Maybe the user should just tell ALSA what speaker setup is
being used, but the applications themself should not need to care about.

If we use 3D coordinates, the panning parameter would not be needed by
the way. All we need is a set of 3D coordinates relative to the
listener. Passing that info to the driver, it can set panning, HRTF
filters, Delay lines, or whatever it provides for that purpose.

Best Regards

Manuel Jander



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
