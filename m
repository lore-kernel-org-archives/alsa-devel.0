From: Ryan Winter <Ryan.Winter@nautronix.com.au>
Subject: Re: RME HDSP 9652 syncing problem
Date: Thu, 20 May 2004 11:59:44 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1085025583.2593.156.camel@winter.nautronix>
References: <1084770662.18496.10.camel@winter.nautronix>
	 <34707.217.235.25.99.1084785191.squirrel@www.undata.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <34707.217.235.25.99.1084785191.squirrel@www.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2004-05-17 at 17:13, Thomas Charbonnel wrote:
> > Hi,
> >
> > I have been using the RME HDSP 9652 for several months now and have
> > noticed a problem with the synchonisation.
> >
> > I have an external word clock which runs into 2 RME analog/digital
> > interfaces, as well as the HDSP itself.
> >
> > The HDSP is setup to sync to word clock input, and sample clock source
> > is autosync.
> >
> > The problem I am seeing is that if I transmit to 24 x 48kHz channels,
> > then the first 8 channels (ADAT-1) seem to continuously loose their Sync
> > status and I can pops (nulls) and clicks (spikes) in the recorded data
> > (by looping the transmit back into receive). Running hdspmixer also
> > shows the levels of the first 8 channels jumping around as the sync is
> > lost.
> >
> > Does anyone know what could be causing this problem? I have attached
> > information about the system that I think is relevant.
> >
> > Thanks
> > Ryan Winter
> >
> >
> 
> Hi Ryan,
> 
> I can't see any problem with your software setup. Moreover the alsa
> controls you use for this are basically only wrappers to hardware
> registers, so I would tend to think that your problem is hardware related.
> What comes to my mind immediately, rather than a faulty card (though it's
> possible), would be a faulty cable or a problem in the WordClock chain. I
> suppose all the external converters you use are slaved to the same device
> as the card, so maybe one of those converters is defective or wired with a
> faulty WordClock cable or termination. What happens if you swap the
> converters ADAT ports ? Do you still get sync issues only on ADAT-1 ? For
> the pops and clicks issue, how do you loop the transmit back into the
> receive ?
> 
> Thomas

I ended up swapping the optical cables around and found one that was
slightly damaged (well almost severed actually). We are getting some
higher quality optical cables in but preliminary tests look good.

Thanks for the tip, I should have known it would be hardware related :D

Ryan Winter

-- 
Apologies for below.
--
This email is confidential and intended solely for the use of the individual to whom it is addressed.  
Any views or opinions presented are solely those of the author and do not necessarily represent those of NAUTRONIX LTD.

If you are not the intended recipient, you have received this email in error and use, dissemination, forwarding, printing, or copying of 
this email is strictly prohibited.  If you have received this email in error please contact the sender.   

Although our computer systems use active virus protection software, and we take various measures to reduce the risk of viruses 
being transmitted in e-mail messages and attachments sent from this company, we cannot guarantee that such e-mail messages 
and attachments are free from viruses on receipt.  It is a condition of our using e-mail to correspond with you, that any and all liability 
on our part arising directly or indirectly out of any virus is excluded.  Please ensure that you run virus checking software on all e-mail 
messages and attachments before reading them.



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
