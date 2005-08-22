From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Playing CD's on 48K-only hardware without resampling...
Date: Mon, 22 Aug 2005 21:40:55 +0100
Message-ID: <430A3857.40509@superbug.co.uk>
References: <430A2FA2.5060004@redfish-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <430A2FA2.5060004@redfish-solutions.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Philip Prindeville <philipp_subx@redfish-solutions.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Philip Prindeville wrote:
> Is there a way to transcode CD PCM streams into
> DTS so that they can be played without having to
> upconvert the signal to 48kHz?
> 
> -Philip
> 

A CD PCM stream converted to DTS would produce a 44.1khz DTS frame, 
which of course would also not play on 48K-only hardware.
The sound playing application should be doing the resampling. I have 
added support for this into xine. So, if it detects a sound card that 
can only do 48Khz, xine uses high quality resamplers instead and then 
outputs to alsa at 48Khz.

James



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
