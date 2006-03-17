From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Fwd: memory allocate for
	substream->runtime->dma_area
Date: Thu, 16 Mar 2006 20:17:37 -0500
Message-ID: <1142558258.9395.34.camel@mindpipe>
References: <715d90900603141942y6c409027sb5a99be13f5ec462@mail.gmail.com>
	 <715d90900603141943h423c0ffdydedec3f1ed50a375@mail.gmail.com>
	 <1142394842.24603.77.camel@mindpipe>
	 <715d90900603142003jd1b1d00he8daf7331cc72237@mail.gmail.com>
	 <1142454177.1671.38.camel@mindpipe>
	 <715d90900603151909o6bb834efv401392e5239a0435@mail.gmail.com>
	 <715d90900603152107q30b76a85l4b428167d515ee8c@mail.gmail.com>
	 <715d90900603152121t40c2c5ddg4e6bce9df9f6e5a9@mail.gmail.com>
	 <441A06A4.7030100@kenati.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <441A06A4.7030100@kenati.com>
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
Cc: boku <boku0712@gmail.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-03-16 at 16:45 -0800, Carlos Munoz wrote:
> Frame: From the macro  bytes_to_frames() I gather that a frame is a 
> sample. For example, if the sample size is 16 bits, the frame is also
> 16 bits. That means that for every 2 bytes sent, one frame is sent.
> 

It's a sample for each channel.  Your example is correct for mono only.
For standard CD format (stereo, 16 bits per sample) a frame is 4 bytes.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
