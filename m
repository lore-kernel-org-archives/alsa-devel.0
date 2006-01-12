From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH] usb-audio: don't use empty packets at start of playback
Date: Thu, 12 Jan 2006 09:48:54 -0800
Message-ID: <20060112174854.GA10856@kroah.com>
References: <20060112084429.GA18332@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20060112084429.GA18332@turing.informatik.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: stable@kernel.org, Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 12, 2006 at 09:44:29AM +0100, Clemens Ladisch wrote:
> Some widespread USB interface chips with adaptive iso endpoints hang
> after receiving a series of empty packets when they expect data.  This
> completely disables audio playback on those devices.  To avoid this, we
> have to send packets containing silence (zero samples) instead.
> 
> ALSA bug: http://bugtrack.alsa-project.org/alsa-bug/view.php?id=1585
> 
> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

Is this upstream in Linus's tree yet?  The Alsa cvs tree yet?

thanks,

greg k-h


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
