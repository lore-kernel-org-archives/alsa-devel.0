From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: HDSP driver update
Date: 07 Apr 2003 15:07:13 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1049720707.1447.3.camel@satellite.undata.org>
References: <E192VvZ-0000Px-00@dardilly>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E192VvZ-0000Px-00@dardilly>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


> >The card won't work until the firmware is uploaded with the hdspload
> >tool. 
> 
> am i right in thinking that this means that the driver will load, but
> the card won't actually work?

The driver will load but only the hwdep interface will be created.
The only way to interact with the card is through the defined hwdep
ioctls. After the firmware is uploaded, all the remaining interfaces are
created (midi, pcm, ctl), and the card is fully functional.




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
