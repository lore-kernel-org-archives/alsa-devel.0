From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Maintaining sound card at a specific frequency
Date: Tue, 18 Jan 2005 16:50:36 +0100 (CET)
Message-ID: <XFMail.20050118165036.pochini@shiny.it>
References: <1105938846.41eb499ec3527@www3.webhosting.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1105938846.41eb499ec3527@www3.webhosting.cx>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@lists.sourceforge.net, Mark Knecht <markknecht@gmail.com>
List-Id: alsa-devel@alsa-project.org


On 17-Jan-2005 Patrick Shirkey wrote:

>> I guess I'm wondering if there isn't some .asoundrc magic that could
>> be done in my Linux account on this machine that would tell all
>> applications (other than Jack for now) to use some virtual device that
>> handles all frequencies. If that virtual device was the default and
>> the resampling (for Mozilla/games/whatever) was done in software and
>> the sound cards frequency was never changed then I think things would
>> work much better.
>>
>
> I think you can use default as the device name in .asoundrc and it
> will be used as the default device for all apps.

IMHO we should think on a good solution for this problem. Some
cards have many channels/voices but the sample rate is common
for all of them. Currently the only clean way to manage it is
a control that locks the sample rate at a given frequency, but
it isn't a nice solution because it requires explicit user
intervention. In the echoaudio driver I implemented a kludge
that automatically locks the sample frequency in order to avoid
unwanted rate changes.


--
Giuliano.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
