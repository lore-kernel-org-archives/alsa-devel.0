From: Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: [ANNOUNCE] USB MIDI support for ALSA
Date: Fri, 17 May 2002 15:57:35 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <acqdub$eeg$2@main.gmane.org>
References: <20020515031105.1BD8D2757@sitemail.everyone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from kroah.com (12-224-36-73.client.attbi.com [12.224.36.73])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id AAA28387
	for <alsa-devel@alsa-project.org>; Sat, 18 May 2002 00:57:54 +0200
Content-Disposition: inline
In-Reply-To: <20020515031105.1BD8D2757@sitemail.everyone.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: pshirkey@boosthardware.com
Cc: alsa-devel@alsa-project.org, linux-usb-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, May 14, 2002 at 08:11:04PM -0700, Patrick Shirkey wrote:
> I'm starting to wonder if it isn't better to write native ALSA support
> into the usb audio driver. Currently it does this with OSS so why not
> just add ALSA to it and be done with it?
> 
> Surely that is the easiest approach. The only reason I see against it
> is latency requirements are better served by having ALSA connect to
> usb instead of usb connect to ALSA. 

Sure, feel free to do it, patches will be gladly accepted :)

thanks,

greg k-h

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
