From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: pcm buffer size
Date: Tue, 25 May 2004 11:49:30 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40B324BA.5060802@superbug.demon.co.uk>
References: <E1BSYzY-0004YC-00@mailer.emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1BSYzY-0004YC-00@mailer.emlix.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?ISO-8859-1?Q?Nicolas_H=FCppelsh=E4user?= <nh@emlix.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Nicolas Hüppelshäuser wrote:
> Hi!
> 
> I'm using alsa 1.0.4.  How can I get a larger alsa buffer size?  The
> maximum size returned by snd_pcm_hw_params_get_buffer_size_max is too
> small.  I found no module option and nothing apropriate within the driver
> code.  Mainly I'm using the snd-usb-audio module but others are also of
> interest.
> 
> best regards
> 	Nicolas Hueppelshaeuser
> --

You cannot. the value returned by 
snd_pcm_hw_params_get_buffer_size_max() is based on the hardware 
limitations. If you need more buffer space, buffer up the data in your 
application.

Cheers
James



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
