From: Sasha Khapyorsky <sashakh@gmail.com>
Subject: Re: AC97 modem support -- docs?
Date: Wed, 14 Dec 2005 22:52:47 +0200
Message-ID: <20051214205247.GA11022@tecr>
References: <20051213140231.24955955.don@dis.org.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20051213140231.24955955.don@dis.org.nz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Donald Gordon <don@dis.org.nz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 14:02 Tue 13 Dec     , Donald Gordon wrote:
> Hi
> 
> From peering at the source, it looks like ALSA supports driving various
> "modems" via drivers like intel8x0m.  I'd like to try and get one of
> these working as a phone line interface with the Asterisk PBX
> software. 

That is nice idea.

> But I can't find documentation on the interface to these
> devices provided by ALSA.  Can anyone point me in the right direction?

The PCM interface is exactly same as with regular audio device, in
addition there are few special controls 'Off-hook Switch' and 'Caller
ID Switch'. Some yet messy example of such interface usage you may find
there http://linmodems.technion.ac.il/sasha/ma/ma-0.000002.tar.gz ,
look in drv_alsa.c file.

Sasha.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
