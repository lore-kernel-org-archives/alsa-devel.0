From: "gerard van dongen" <gml@xs4all.nl>
Subject: Re: C-Port midi bug.
Date: Fri, 29 Apr 2005 09:43:43 +0200
Message-ID: <opspzg25rw0segih@localhost>
References: <20050427193028.B7CA288863@sc8-sf-spam1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050427193028.B7CA288863@sc8-sf-spam1.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Apr 2005 12:27:56 -0700, Clemens Ladisch wrote:


>> Geoff Beasley wrote:
>> > I have midi output OK but no input.
>>
>> This is the same old well-known bug -- for some reason, the MIDI
>> interrupt isn't enabled.
>>
>> I think it may be possible to change the driver to use polling
>> instead.
> Please try this patch.



Tried it with 1.0.9rc2.
No luck unfortunately.

Gerard




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=3D105hix
