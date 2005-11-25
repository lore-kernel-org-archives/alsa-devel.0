From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: The EMU 0404 soundcard and the Audigy driver...
Date: Fri, 25 Nov 2005 16:20:47 +0000
Message-ID: <438739DF.3030801@superbug.co.uk>
References: <ea4102e90511242031w2fb02dbcqfa0da72db999ddcd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <ea4102e90511242031w2fb02dbcqfa0da72db999ddcd@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tyler Knott <tknott@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Tyler Knott wrote:
> I'm not quiet sure whether to post this here or on the alsa-user
> mailing list, but seeing as this information is more usefule to the
> development of than use of ALSA I decided to put it here.
> 
> I have an EMU 0404 soundcard and I just tried the patch below (adapted
> from the one suggested at
> http://article.gmane.org/gmane.linux.alsa.devel/22204) to try and get
> the EMU10k1/Audigy driver to work with this card.  It does recognize
> it, but I don't get any sound (not that I expected to anyways).  Mixer
> settings do not seem to have any affect (and curiously none of the
> channels, except for the Tone channel, are muteable).
> 

The EMU0404 is not currently supported in Linux yet. The reason you get 
no sound is because the EMU0404 has a FPGA on it, that we don't yet know 
how to program.
I have an EMU1212m that I am working on reverse engineering, so bear 
with us.

James



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
