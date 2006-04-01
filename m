From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: snd_pcm_hw_params_get_period_size() returning 0
Date: Fri, 31 Mar 2006 20:59:55 -0500
Message-ID: <1143856796.2885.4.camel@mindpipe>
References: <442DD097.40901@kenati.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <442DD097.40901@kenati.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Carlos Munoz <carlos@kenati.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-03-31 at 17:00 -0800, Carlos Munoz wrote:
> Does 
> any one know why
> snd_pcm_hw_params_get_period_size() would be returning 0 ? Is it 
> something the driver did/didn't do ?
> 

Argh, please disregard last message, that's not how the hw_params
callback works :-(

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
