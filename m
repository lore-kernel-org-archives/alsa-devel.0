From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: RME 9632 Mixer...
Date: Wed, 26 May 2004 19:46:34 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <34947.217.81.127.171.1085593594.squirrel@www.undata.org>
References: <40B3A472.5050206@wildgooses.com>
        <Pine.HPX.4.33n.0405261744140.27472-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0405261744140.27472-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: clemens@ladisch.de
Cc: lists@wildgooses.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Ed Wildgoose wrote:
>> Can anyone suggest how to script the controls to default to some known
>> values?
>
> "alsactl store" saves the current values of all mixer control in
> /etc/asound.state, "alsactl restore" restores them.
>
>
> HTH
> Clemens
>
>

 Hi Clemens, hi Ed,

This is not a standard mixer control, alsactl is of no use here.
Ed, here's a script for 1:1 routing (hdspmixer preset 1)

#! /bin/bash

for out_left in $(seq 0 2 16);
do
let out_right=$out_left+1
let in_left=$out_left+16
let in_right=$out_right+16
amixer cset numid=5 $in_left,$out_left,32768
amixer cset numid=5 $in_right,$out_right,32768
done;

This script assumes the hdsp is the default card, if it's not, just add
'-c X' (where X is your hdsp's alsa card number) between 'amixer' and
'cset'.

Thomas





-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
