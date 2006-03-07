From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Mix two mono streams into one stereo.
Date: Tue, 07 Mar 2006 11:23:51 -0500
Message-ID: <1141748631.767.13.camel@mindpipe>
References: <1141737495.6054.6.camel@jazc.fedora>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1141737495.6054.6.camel@jazc.fedora>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Juan Zapatero <jazc@gmvsistemas.es>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-03-07 at 13:18 +0000, Juan Zapatero wrote:
> I need some help with this. I have written a VoIP application which
> captures audio from a microphone input, and plays audio coming through
> the network to de audio output.
> 
> This application is intended to run on a system with a sound-card that
> has only one stereo output, and two different audio streams have to be
> played both at the same time through this stereo output. So I need to
> mix both mono streams into one stereo stream using ALSA Api.
> 
> How is this possible?

Just use JACK, this exposes the two output channels as independent
ports, and write your app as a JACK client (or multiple clients)

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
