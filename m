From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: matrix mixer control (Re: Complex mixer questio
Date: Wed, 02 Apr 2003 15:51:54 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E8AEAFA.4090204@libero.it>
References: <Pine.LNX.4.44.0304021418180.3649-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0304021418180.3649-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Giuliano Pochini <pochini@shiny.it>, alsa-devel <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela ha scritto:
> On Wed, 2 Apr 2003, Abramo Bagnara wrote:
> 
> 
>>Jaroslav Kysela ha scritto:
>>
>>>On Tue, 1 Apr 2003, Abramo Bagnara wrote:
>>>
>>>
>>>
>>>>I agree with Jaroslav fully:
>>>>- have one ALSA control for each primitive hw control (1536 different 
>>>>controls)
>>>>- add a field to struct sndrv_ctl_elem_info explaining how index field 
>>>>of sndvr_ctl_elem_id should be interpreted (32,16+16,10+11+11, ecc.)
>>>>
>>>>This permit to have native support for N dimensional control.
>>>>
>>>>About kernel memory issues, this concerns easily solvable implementation 
>>>>detail to not worry about when designing sane API.
>>>
>>>
>>>Ok, I've added the dimension description to the info structure. Although 
>>>it is completely irrelevant to data transfers.
>>>
>>>Also, I've implemented multi element in the kernel space to save memory 
>>>and it makes the searching faster. The reference code is in the trident 
>>>driver. I'll recode other drivers containing many "same" controls to use 
>>>this method later.
>>
>>The lack of sparse matrix support I see in your implementation is a very 
>>unfortunate design choice.
>>
>>I suggest you to use an hash table pointing to a pair { kcontrol_index, 
>>kcontrol_volatile_index } (16+16 should be enough) for control id 
>>searching and to move index info into snd_kcontrol_volatile_t.
> 
> 
> I don't understand. The matrix is simply mapped to linear space. There is
> no requirement to do something special.

Perhaps I'm beginning to understand: you're using ordinary access for 
first N-1 dimensions and snd_kcontrol_volatile_t only for last dimension 
and only for contiguous values of index.

I believe this is not the right approach and linear search on a large 
number of controls should be avoided (because not scalable).

Also suppose to have a 10*10 control matrix but for each row but #3 you 
don't have a control for column #2, #4 and #6.

With your solution you still need to have 4*9+1=37 separate but 
identical snd_kcontrol_t instead of 1 if you adopt the solution I propose.

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
